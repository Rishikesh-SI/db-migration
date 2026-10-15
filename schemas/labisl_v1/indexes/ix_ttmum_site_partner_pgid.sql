-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labisl_v1.labisl_v1_page_partner USING btree (page_id);


--
