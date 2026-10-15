-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_site_partner_sid
-- Type: INDEX

-- Name: ix_kxp_site_partner_sid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_site_partner_sid ON kxp.kxp_site_partner USING btree (site_id);


--
