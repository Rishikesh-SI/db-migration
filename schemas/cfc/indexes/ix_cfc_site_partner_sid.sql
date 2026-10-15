-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_site_partner_sid
-- Type: INDEX

-- Name: ix_cfc_site_partner_sid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_site_partner_sid ON cfc.cfc_site_partner USING btree (site_id);


--
