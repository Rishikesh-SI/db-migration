-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labgfg.labgfg_site_partner USING btree (site_id);


--
