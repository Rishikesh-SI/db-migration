-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_site_partner_sid
-- Type: INDEX

-- Name: ix_mum_site_partner_sid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_site_partner_sid ON dhm.dhm_site_partner USING btree (site_id);


--
