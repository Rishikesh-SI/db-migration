-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labdd_v1_30april24; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labdd_v1_30april24.labdd_v1_page_partner USING btree (page_id);


--
