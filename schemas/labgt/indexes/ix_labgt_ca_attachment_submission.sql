-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_labgt_ca_attachment_submission
-- Type: INDEX

-- Name: ix_labgt_ca_attachment_submission; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_labgt_ca_attachment_submission ON labgt.labgt_ca_attachment USING btree (submission_id);


--
