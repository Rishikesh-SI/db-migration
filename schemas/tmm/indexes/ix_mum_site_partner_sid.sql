-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_site_partner_sid
-- Type: INDEX

-- Name: ix_mum_site_partner_sid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_site_partner_sid ON tmm.tmm_site_partner USING btree (site_id);


--
