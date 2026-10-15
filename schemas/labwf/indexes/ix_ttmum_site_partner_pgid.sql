-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labwf.labwf_page_partner USING btree (page_id);


--
