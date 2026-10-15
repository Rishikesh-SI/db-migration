-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_poll_option labacko_poll_option_id
-- Type: CONSTRAINT

-- Name: labacko_poll_option labacko_poll_option_id; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_poll_option
    ADD CONSTRAINT labacko_poll_option_id PRIMARY KEY (poll_option_id);


--
