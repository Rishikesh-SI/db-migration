-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_site_partner_pgid
-- Type: INDEX

-- Name: ix_kxp_site_partner_pgid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_site_partner_pgid ON kxp.kxp_page_partner USING btree (page_id);


--
