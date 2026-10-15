-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labpcm.labpcm_page_partner USING btree (page_id);


--
