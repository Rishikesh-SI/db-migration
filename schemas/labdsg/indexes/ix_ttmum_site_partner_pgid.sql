-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labdsg.labdsg_page_partner USING btree (page_id);


--
