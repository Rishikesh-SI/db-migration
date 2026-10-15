-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labsrk.labsrk_page_partner USING btree (page_id);


--
