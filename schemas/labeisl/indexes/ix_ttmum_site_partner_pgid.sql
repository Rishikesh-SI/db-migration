-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labeisl.labeisl_page_partner USING btree (page_id);


--
