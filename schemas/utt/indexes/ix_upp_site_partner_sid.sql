-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_site_partner_sid
-- Type: INDEX

-- Name: ix_upp_site_partner_sid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_site_partner_sid ON utt.utt_site_partner USING btree (site_id);


--
