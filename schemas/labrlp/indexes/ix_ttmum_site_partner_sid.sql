-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labrlp.labrlp_site_partner USING btree (site_id);


--
