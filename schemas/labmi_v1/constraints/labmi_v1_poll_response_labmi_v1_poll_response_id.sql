-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_poll_response labmi_v1_poll_response_id
-- Type: CONSTRAINT

-- Name: labmi_v1_poll_response labmi_v1_poll_response_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_poll_response
    ADD CONSTRAINT labmi_v1_poll_response_id PRIMARY KEY (poll_response_id);


--
