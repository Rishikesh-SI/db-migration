-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ux_labgt_ca_submission_dedupe
-- Type: INDEX

-- Name: ux_labgt_ca_submission_dedupe; Type: INDEX; Schema: labgt; Owner: -
--

CREATE UNIQUE INDEX ux_labgt_ca_submission_dedupe ON labgt.labgt_ca_submission USING btree (campaign_metadata_id, dedupe_key) WHERE (dedupe_key IS NOT NULL);


--
