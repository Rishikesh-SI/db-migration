-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labadkr.labadkr_site_partner USING btree (site_id);


--
