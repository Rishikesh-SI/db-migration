-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labpvl.labpvl_page_partner USING btree (page_id);


--
