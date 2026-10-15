-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_site_partner_pgid
-- Type: INDEX

-- Name: ix_kxp_site_partner_pgid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_site_partner_pgid ON labkxp1.labkxp_page_partner USING btree (page_id);


--
