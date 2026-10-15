-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_site_partner_sid
-- Type: INDEX

-- Name: ix_pkl_site_partner_sid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_site_partner_sid ON labpkl.labpkl_site_partner USING btree (site_id);


--
