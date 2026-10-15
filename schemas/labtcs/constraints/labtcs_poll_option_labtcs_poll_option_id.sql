-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_poll_option labtcs_poll_option_id
-- Type: CONSTRAINT

-- Name: labtcs_poll_option labtcs_poll_option_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_poll_option
    ADD CONSTRAINT labtcs_poll_option_id PRIMARY KEY (poll_option_id);


--
