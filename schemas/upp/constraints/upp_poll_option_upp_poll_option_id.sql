-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_poll_option upp_poll_option_id
-- Type: CONSTRAINT

-- Name: upp_poll_option upp_poll_option_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_poll_option
    ADD CONSTRAINT upp_poll_option_id PRIMARY KEY (poll_option_id);


--
