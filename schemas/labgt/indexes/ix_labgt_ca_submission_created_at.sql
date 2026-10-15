-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_labgt_ca_submission_created_at
-- Type: INDEX

-- Name: ix_labgt_ca_submission_created_at; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_labgt_ca_submission_created_at ON labgt.labgt_ca_submission USING btree (created_at);


--
