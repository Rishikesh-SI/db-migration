-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labbsc_old.labbsc_page_partner USING btree (page_id);


--
