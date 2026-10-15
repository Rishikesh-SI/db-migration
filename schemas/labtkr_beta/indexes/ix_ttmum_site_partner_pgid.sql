-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labtkr_beta.labtkr_page_partner USING btree (page_id);


--
