-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labgg.labgg_site_partner USING btree (site_id);


--
