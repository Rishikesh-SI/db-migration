-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labwf.labwf_site_partner USING btree (site_id);


--
