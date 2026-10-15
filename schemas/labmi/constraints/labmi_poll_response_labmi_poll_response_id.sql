-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_poll_response labmi_poll_response_id
-- Type: CONSTRAINT

-- Name: labmi_poll_response labmi_poll_response_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_poll_response
    ADD CONSTRAINT labmi_poll_response_id PRIMARY KEY (poll_response_id);


--
