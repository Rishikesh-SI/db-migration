-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: idx_orders_userid
-- Type: INDEX

-- Name: idx_orders_userid; Type: INDEX; Schema: test14; Owner: -
--

CREATE INDEX idx_orders_userid ON test14.orders USING btree (user_id);


--
