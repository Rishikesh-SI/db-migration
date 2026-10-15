-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labwafdemo; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labwafdemo.labwafdemo_page_partner USING btree (page_id);


--
