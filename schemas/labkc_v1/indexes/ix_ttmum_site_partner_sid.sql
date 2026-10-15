-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labkc_v1.labkc_v1_site_partner USING btree (site_id);


--
