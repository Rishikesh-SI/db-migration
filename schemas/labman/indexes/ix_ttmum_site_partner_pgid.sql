-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labman.labman_page_partner USING btree (page_id);


--
