import time
from db import table

def run_keepalive():
    cur = table.cursor()
    try:
        # Get current time as counter
        counter = int(time.time())
        print(f"Pinging Supabase. Updating keepalive counter to {counter}...")
        cur.execute(
            "UPDATE keepalive SET counter = %s, updated_at = NOW() WHERE id = 1",
            (counter,)
        )
        table.commit()
        # Verify
        cur.execute("SELECT * FROM keepalive WHERE id = 1")
        row = cur.fetchone()
        print(f"[SUCCESS] Supabase pinged successfully! New row state: {row}")
    except Exception as e:
        print(f"[ERROR] Error pinging Supabase: {e}")
    finally:
        cur.close()

if __name__ == "__main__":
    run_keepalive()
