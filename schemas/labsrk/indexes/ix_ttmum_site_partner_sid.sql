-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_site_partner_sid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_sid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_sid ON labsrk.labsrk_site_partner USING btree (site_id);


--
