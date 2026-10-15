-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labpr.labpr_site_partner USING btree (site_id);


--
