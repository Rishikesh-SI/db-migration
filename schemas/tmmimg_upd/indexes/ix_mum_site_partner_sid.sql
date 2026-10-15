-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_site_partner_sid
-- Type: INDEX

-- Name: ix_mum_site_partner_sid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_site_partner_sid ON tmmimg_upd.tmmimg_upd_site_partner USING btree (site_id);


--
