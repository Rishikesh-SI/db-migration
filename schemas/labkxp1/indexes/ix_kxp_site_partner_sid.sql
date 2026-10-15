-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_site_partner_sid
-- Type: INDEX

-- Name: ix_kxp_site_partner_sid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_site_partner_sid ON labkxp1.labkxp_site_partner USING btree (site_id);


--
