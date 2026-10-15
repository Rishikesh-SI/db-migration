-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_site_partner_sid
-- Type: INDEX

-- Name: ix_tfa_site_partner_sid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_site_partner_sid ON tfa.tfa_site_partner USING btree (site_id);


--
