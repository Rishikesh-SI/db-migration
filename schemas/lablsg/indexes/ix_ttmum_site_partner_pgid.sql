-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON lablsg.lablsg_page_partner USING btree (page_id);


--
