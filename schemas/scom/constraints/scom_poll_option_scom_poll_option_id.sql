-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_poll_option scom_poll_option_id
-- Type: CONSTRAINT

-- Name: scom_poll_option scom_poll_option_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_poll_option
    ADD CONSTRAINT scom_poll_option_id PRIMARY KEY (poll_option_id);


--
