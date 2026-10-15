-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labspz_v1.labspz_v1_site_partner USING btree (site_id);


--
