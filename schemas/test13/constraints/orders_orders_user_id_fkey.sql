-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test13
-- Object: orders orders_user_id_fkey
-- Type: FK CONSTRAINT

-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: test13; Owner: -
--

ALTER TABLE ONLY test13.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES test13.users(user_id);


--
