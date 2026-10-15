-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labso_bkp.labso_page_partner USING btree (page_id);


--
