-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_poll_option jafc_poll_option_id
-- Type: CONSTRAINT

-- Name: jafc_poll_option jafc_poll_option_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_poll_option
    ADD CONSTRAINT jafc_poll_option_id PRIMARY KEY (poll_option_id);


--
