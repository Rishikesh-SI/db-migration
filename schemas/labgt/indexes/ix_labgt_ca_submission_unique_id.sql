-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_labgt_ca_submission_unique_id
-- Type: INDEX

-- Name: ix_labgt_ca_submission_unique_id; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_labgt_ca_submission_unique_id ON labgt.labgt_ca_submission USING btree (unique_id) WHERE (unique_id IS NOT NULL);


--
