-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_labgt_ca_submission_json_gin
-- Type: INDEX

-- Name: ix_labgt_ca_submission_json_gin; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_labgt_ca_submission_json_gin ON labgt.labgt_ca_submission USING gin (submission_json);


--
