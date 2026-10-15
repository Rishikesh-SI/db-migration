-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_site_partner_sid
-- Type: INDEX

-- Name: ix_jafc_site_partner_sid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_site_partner_sid ON jafc.jafc_site_partner USING btree (site_id);


--
