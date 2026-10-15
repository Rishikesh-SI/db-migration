-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_site_partner_pgid
-- Type: INDEX

-- Name: ix_cfc_site_partner_pgid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_site_partner_pgid ON cfc.cfc_page_partner USING btree (page_id);


--
