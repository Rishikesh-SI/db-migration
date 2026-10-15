-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_site_partner_pgid
-- Type: INDEX

-- Name: ix_mum_site_partner_pgid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_site_partner_pgid ON tmmimg_upd.tmmimg_upd_page_partner USING btree (page_id);


--
