-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_site_partner_pgid
-- Type: INDEX

-- Name: ix_jafc_site_partner_pgid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_site_partner_pgid ON jafc.jafc_page_partner USING btree (page_id);


--
