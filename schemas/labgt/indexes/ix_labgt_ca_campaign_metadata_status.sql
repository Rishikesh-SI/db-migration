-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_labgt_ca_campaign_metadata_status
-- Type: INDEX

-- Name: ix_labgt_ca_campaign_metadata_status; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_labgt_ca_campaign_metadata_status ON labgt.labgt_ca_campaign_metadata USING btree (status);


--
