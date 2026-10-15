-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_site_partner_sid
-- Type: INDEX

-- Name: ix_kxp_site_partner_sid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_site_partner_sid ON labstlz.labstlz_site_partner USING btree (site_id);


--
