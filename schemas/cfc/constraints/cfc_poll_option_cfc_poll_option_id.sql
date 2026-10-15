-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_poll_option cfc_poll_option_id
-- Type: CONSTRAINT

-- Name: cfc_poll_option cfc_poll_option_id; Type: CONSTRAINT; Schema: cfc; Owner: -
--

ALTER TABLE ONLY cfc.cfc_poll_option
    ADD CONSTRAINT cfc_poll_option_id PRIMARY KEY (poll_option_id);


--
